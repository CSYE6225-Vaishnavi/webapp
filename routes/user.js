const express = require("express");
const userController = require('../controllers/user');

const userRouter = express.Router();

userRouter.route('/')
    .post(userController.createUser);

userRouter.route('/:userId')
    .get(userController.getUser);


userRouter.route('/')
    .get(userController.getHealth);

userRouter.route('/:userId')  
    .put(userController.editUser);

module.exports = userRouter;        