import { config } from 'dotenv';
import { Sequelize } from 'sequelize';

config();

const DB_URL = process.env.DB_URL || process.env.DATABASE_URL;

const baseOptions = {
  dialect: 'postgres',
};

const remoteOptions = {
  ...baseOptions,
  dialectOptions: {
    ssl: {
      require: true,
      rejectUnauthorized: false,
    },
  },
};

const localOptions = {
  ...baseOptions,
  host: 'localhost',
};

const sequelize = DB_URL
  ? new Sequelize(DB_URL, remoteOptions)
  : new Sequelize('taskdb', 'postgres', 'yourpassword', localOptions);

export default sequelize;
