import React from "react";

function TaskItem({ task, toggleTask, deleteTask }) {
  return (
    <li className={`task-item ${task.completed ? "completed" : ""}`}>
      <div
        className="task-content"
        onClick={() => toggleTask(task.id, task.completed)}
      >
        <div className="checkbox" />
        <span className="task-text">{task.title}</span>
      </div>
      <button
        className="delete-btn"
        onClick={(e) => {
          e.stopPropagation();
          deleteTask(task.id);
        }}
      >
        Delete
      </button>
    </li>
  );
}

export default TaskItem;
