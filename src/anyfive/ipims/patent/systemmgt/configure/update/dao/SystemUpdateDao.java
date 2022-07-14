package anyfive.ipims.patent.systemmgt.configure.update.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;

public class SystemUpdateDao extends NAbstractServletDao
{
    public SystemUpdateDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업데이트 쿼리 실행
     *
     * @param query
     * @throws NException
     */
    public void executeSystemUpdate(String query) throws NException
    {
        PreparedStatement pstmt = null;

        try {
            pstmt = this.nsr.getConnection().prepareStatement(query);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new NSysException(e.getMessage() + "\n" + query);
        } finally {
            this.nsr.close(pstmt);
        }
    }
}
