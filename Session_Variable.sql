-- Session --> A series of information exchange interaction, or a dialogue between user and computer
-- Session Variable --> A variable which exists in a session we are operating
		-- It is defined on our server and lives there
        -- it is visible to the connection/ session being used only in which it is created

-- Declaring a session variable
SET @s_var1 = 3;

-- Calling that variable
SELECT @s_var1;

-- Now as this is a session variable and we are working on a same server so, now we can create as many session as we like
-- it will return the same value
-- But this variable won't work in a new connection on new server and will return a null value


-- Both local/ user-defined and system variables can be used as session variables, but there are limitations e-g
SET SESSION max_connections = 100;


