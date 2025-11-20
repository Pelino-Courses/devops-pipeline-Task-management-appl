import express from 'express';
import cors from 'cors';
import sequelize from './config/db.js';

import taskRoutes from './routes/taskRoutes.js';

const app = express();
const PORT = process.env.PORT || 2000;

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/tasks', taskRoutes);

// Connect DB
sequelize.sync().then(() => {
  console.log('Database connected');
  app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
});
