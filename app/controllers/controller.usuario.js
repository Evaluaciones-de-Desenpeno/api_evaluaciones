import pool from "../config/mysql.db";
import bcrypt, {hash} from "bcrypt";
import {success, error} from "../messages/browser";
import { config } from "dotenv";
import jwt from "jsonwebtoken"; 

config();



const mostarUsuarios = async (req, res) => {
    try{
        const [respuesta] = await pool.query(`CALL SP_MOSTRAR_USUARIOS();`);
        success(req, res, 200, respuesta[0]);
        
    } catch (err){
        error(req, res, 500, err);
    }
};



const crearUsuario = async (req, res) => {
    const { rol_id, nombre, correo} = req.body;
    const contrasenasincifrar = req.body.contrasena;


    if (!rol_id || !nombre || !correo || !contrasenasincifrar) {
        return error(req, res, 400, "Todos los campos son obligatorios");
    }

    try {
        const hash = await bcrypt.hash(contrasenasincifrar, 10); 
        const contrasena = hash;

        const respuesta = await pool.query(`CALL SP_INSERTAR_USUARIO("${rol_id}", "${nombre}", "${correo}", "${contrasena}");`);

        if (respuesta[0].affectedRows === 1) {
            success(req, res, 201, "Usuario creado correctamente");
        } else {
            error(req, res, 400, "No se pudo crear el usuario");
        }
    } catch (err) {
        error(req, res, 500, err.message);
    }
};



const loginusuario = async (req, res) => {
    const { correo, contrasena } = req.body;

    try {
        // Llamar al procedimiento almacenado
        const [rows] = await pool.query(`CALL SP_LOGIN_USUARIO(?);`, [correo]);

        if (rows[0].length === 0) {
            return error(req, res, 404, "El usuario no existe.");
        }

        const usuario = rows[0][0]; // Acceder al primer resultado del procedimiento almacenado

        // Comparar la contraseña proporcionada con la contraseña cifrada
        const match = await bcrypt.compare(contrasena, usuario.contrasena);
        if (!match) {
            return error(req, res, 401, "Contraseña incorrecta.");
        }

        // Generar un token JWT con la información del usuario y la bodega
        const token = jwt.sign(
            {
                usuario_id: usuario.usuario_id,
                rol_id: usuario.rol_id,
                nombre: usuario.nombre,
                correo: usuario.rol,
            },
            process.env.TOKEN_PRIVATEKEY, // Clave secreta
            { expiresIn: process.env.TOKEN_EXPIRES_IN } // Expiración del token
        );

        // Devolver una respuesta exitosa con el token y la información del usuario
        res.status(200).json({
            message: "Bienvenido",
            token: token,
            usuario: {
                usuario_id: usuario.usuario_id,
                rol_id: usuario.rol_id,
                nombre: usuario.nombre,
                correo: usuario.rol, // Incluir la bodega en la respuesta
            },
        });
    } catch (e) {
        console.error("Error en loginusuario:", e);
        error(req, res, 500, "Error en el servidor, por favor intente de nuevo.");
    }
};



export {crearUsuario, loginusuario};