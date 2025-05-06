import { Router } from 'express';
import { crearUsuario, loginusuario } from '../controllers/controller.usuario.js';


const rutausuario = Router();



rutausuario.post("/usuario", crearUsuario);
rutausuario.post("/login",loginusuario);



export default rutausuario;