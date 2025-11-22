import React, { useState, useEffect } from "react";
import api from "./api/axios";
import TaskList from "./components/TaskList";
import "./styles.css";

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  useEffect(() => {
    const fetchTasks = async () => {
      const res = await api.get("/tasks");
      setTasks(res.data);
    };
    fetchTasks();
  }, []);

  const addTask = async () => {
    if (!title) return;
    const res = await api.post("/tasks", { title });
    setTasks([...tasks, res.data]);
    setTitle("");
  };

  const toggleTask = async (id, completed) => {
    const res = await api.put(`/tasks/${id}`, { completed: !completed });
    setTasks(tasks.map(t => (t.id === id ? res.data : t)));
  };

  const deleteTask = async (id) => {
    await api.delete(`/tasks/${id}`);
    setTasks(tasks.filter(t => t.id !== id));
  };

  return (
    <div className="container">
      <h1>Task Management App</h1>
      <div className="task-input">
        <input
          type="text"
          value={title}
          placeholder="Enter new task..."
          onChange={(e) => setTitle(e.target.value)}
        />
        <button onClick={addTask}> Add </button>
      </div>

      <TaskList
        tasks={tasks}
        toggleTask={toggleTask}
        deleteTask={deleteTask}
      />
    </div>
  );
}

export default App;
