const express = require("express");
const cors = require("cors");
const multer = require("multer");
const { BlobServiceClient } = require("@azure/storage-blob");

const app = express();

const PORT = process.env.PORT || 3002;

app.use(cors());

const upload = multer({
    storage: multer.memoryStorage()
});

const connectionString = process.env.AZURE_STORAGE_CONNECTION_STRING;
const containerName = process.env.AZURE_STORAGE_CONTAINER || "attachments";

const blobServiceClient =
    BlobServiceClient.fromConnectionString(connectionString);

const containerClient =
    blobServiceClient.getContainerClient(containerName);

app.get("/health", (req, res) => {
    res.json({
        status: "File Service is healthy"
    });
});

app.post("/files", upload.single("file"), async (req, res) => {
    try {

        if (!req.file) {
            return res.status(400).json({
                message: "No file uploaded"
            });
        }

        const filename =
            Date.now() + "-" + req.file.originalname;

        const blockBlobClient =
            containerClient.getBlockBlobClient(filename);

        await blockBlobClient.uploadData(req.file.buffer);

        res.status(201).json({
            message: "File uploaded successfully",
            filename: filename
        });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: "Unable to upload file"
        });
    }
});

app.get("/files/:filename", async (req, res) => {
    try {

        const blobClient =
            containerClient.getBlobClient(req.params.filename);

        const downloadResponse =
            await blobClient.download();

        res.setHeader(
            "Content-Type",
            downloadResponse.contentType || "application/octet-stream"
        );

        downloadResponse.readableStreamBody.pipe(res);

    } catch (error) {

        console.error(error);

        res.status(404).json({
            message: "File not found"
        });
    }
});

app.listen(PORT, () => {
    console.log(`File Service running on port ${PORT}`);
});