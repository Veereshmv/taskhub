const express = require("express");
const cors = require("cors");
const sql = require("mssql");

const app = express();

const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const dbConfig = {
    user: process.env.SQL_USER,
    password: process.env.SQL_PASSWORD,
    server: process.env.SQL_SERVER,
    database: process.env.SQL_DATABASE,

    options: {
        encrypt: true,
        trustServerCertificate: false
    }
};

app.get("/health", (req, res) => {
    res.json({
        status: "Task Service is healthy"
    });
});

app.get("/tasks", async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig);

        const result = await pool.request().query(
            "SELECT * FROM Tasks ORDER BY id DESC"
        );

        res.json(result.recordset);

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Unable to retrieve tasks"
        });
    }
});

app.post("/tasks", async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig);

        const result = await pool.request()
            .input("taskName", sql.NVarChar, req.body.taskName)
            .input("description", sql.NVarChar, req.body.description)
            .query(`
                INSERT INTO Tasks (taskName, description, status)
                OUTPUT INSERTED.*
                VALUES (@taskName, @description, 'Pending')
            `);

        res.status(201).json(result.recordset[0]);

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Unable to create task"
        });
    }
});

app.put("/tasks/:id", async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig);

        const result = await pool.request()
            .input("id", sql.Int, req.params.id)
            .input("status", sql.NVarChar, req.body.status)
            .query(`
                UPDATE Tasks
                SET status = @status
                OUTPUT INSERTED.*
                WHERE id = @id
            `);

        if (result.recordset.length === 0) {
            return res.status(404).json({
                message: "Task not found"
            });
        }

        res.json(result.recordset[0]);

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Unable to update task"
        });
    }
});

app.delete("/tasks/:id", async (req, res) => {
    try {
        const pool = await sql.connect(dbConfig);

        const result = await pool.request()
            .input("id", sql.Int, req.params.id)
            .query(`
                DELETE FROM Tasks
                WHERE id = @id
            `);

        if (result.rowsAffected[0] === 0) {
            return res.status(404).json({
                message: "Task not found"
            });
        }

        res.json({
            message: "Task deleted"
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Unable to delete task"
        });
    }
});

app.listen(PORT, () => {
    console.log(`Task Service running on port ${PORT}`);
});