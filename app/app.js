import express from 'express';
import {config} from 'dotenv';
import morgan from 'morgan';
import ruta from './routers/index.js';
// import cors from 'cors';



config();


const app = express();

app.use(morgan('dev'));
app.use(express.json());
// app.use(cors({
//     origin: process.env.FRONTEND_URL,
//     Credentials: true,
// }));
app.set("PORT", process.env.PORT || 2000);

app.use("/", ruta)

export default app;