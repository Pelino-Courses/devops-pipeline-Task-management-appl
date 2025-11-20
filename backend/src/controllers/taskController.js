import Task from '../models/Task.js';

export const getTasks = async (req, res) => {
  const tasks = await Task.findAll();
  res.json(tasks);
};

export const createTask = async (req, res) => {
  const { title } = req.body;
  const task = await Task.create({ title });
  res.json(task);
};

export const updateTask = async (req, res) => {
  const { id } = req.params;
  const { completed } = req.body;

  const task = await Task.findByPk(id);
  task.completed = completed;
  await task.save();

  res.json(task);
};

export const deleteTask = async (req, res) => {
  const { id } = req.params;

  await Task.destroy({ where: { id } });
  res.json({ message: 'Task deleted' });
};
