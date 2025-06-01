import { Router } from 'express';
import { crearUsuario, loginusuario, obtenerRoles } from '../controllers/controller.usuario.js';


const rutausuario = Router();



rutausuario.post("/usuario", crearUsuario);
rutausuario.post("/login",loginusuario);
rutausuario.get("/roles", obtenerRoles);



export default rutausuario;