package anyfive.framework.dao;

import java.io.OutputStream;
import java.io.Writer;
import java.sql.ResultSet;

import oracle.sql.CLOB;
import any.util.dao.NLobAbstractWriter;

public class LobWriter implements NLobAbstractWriter
{
    public OutputStream getBlobWriter(ResultSet rs, String key) throws Exception
    {
        return null;
    }

    public Writer getClobWriter(ResultSet rs, String key) throws Exception
    {
        return ((CLOB)rs.getClob(key)).getCharacterOutputStream();
    }
}
