-- Global variables --> apply to all connections related to a specific server
-- A specific group of pre-defined variables in MySQL is suitable to be declared as global variable. they are called system variables
SET @@global.max_connections = 1;

-- Now our work bench can only have 1 connection to the server

SET GLOBAL max_connections = 100; -- aloowing 100 connections using global variables