package anyfive.framework.connection;

import java.sql.Connection;
import java.sql.DriverManager;

import any.core.config.NConfig;
import any.core.connection.NAbstractConnectionManager;

public class HRConnectionManager implements NAbstractConnectionManager
{
    public Connection getConnection(String name) throws Exception
    {
        Class.forName(this.getConnectionInfo(name, "driver"));

        String url = this.getConnectionInfo(name, "url");
        String username = this.getConnectionInfo(name, "username");
        String password = this.getConnectionInfo(name, "password");

        return DriverManager.getConnection(url, username, password);
    }

    public void closeConnection(String name, Connection conn) throws Exception
    {
        conn.close();
    }

    private String getConnectionInfo(String name, String info)
    {

        return NConfig.getString(NConfig.DEFAULT_CONFIG + "/connection[@name=\"" + name + "\"]/connection-info/" + info);
    }
}
