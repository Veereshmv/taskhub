let taskApiUrl;
let fileApiUrl;

async function loadConfig() {
    const response = await fetch("/config");
    const config = await response.json();

    taskApiUrl = config.taskApiUrl;
    fileApiUrl = config.fileApiUrl;

    loadTasks();
}

async function loadTasks() {
    const response = await fetch(`${taskApiUrl}/tasks`);
    const tasks = await response.json();

    const taskList = document.getElementById("taskList");

    taskList.innerHTML = "";

    tasks.forEach(task => {
        taskList.innerHTML += `
            <div class="task">
                <strong>${task.taskName}</strong>
                <p>${task.description}</p>
                <p>Status: ${task.status}</p>
            </div>
        `;
    });
}

async function createTask() {
    const taskName = document.getElementById("taskName").value;
    const description = document.getElementById("description").value;

    if (!taskName) {
        alert("Please enter a task name");
        return;
    }

    await fetch(`${taskApiUrl}/tasks`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            taskName: taskName,
            description: description
        })
    });

    document.getElementById("taskName").value = "";
    document.getElementById("description").value = "";

    loadTasks();
}

async function uploadFile() {
    const fileInput = document.getElementById("fileInput");

    if (!fileInput.files.length) {
        alert("Please choose a file");
        return;
    }

    const formData = new FormData();

    formData.append("file", fileInput.files[0]);

    const response = await fetch(`${fileApiUrl}/files`, {
        method: "POST",
        body: formData
    });

    const result = await response.json();

    alert(result.message);
}

loadConfig();