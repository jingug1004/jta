package anyfive.framework.userlog.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.exception.NSysException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;

public class UserLogDao extends NAbstractServletDao
{
    public UserLogDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사용자 로그 생성
     *
     * @param data
     * @return
     * @throws NException
     */
    public int createUserLog(NSingleData data) throws NException
    {
        PreparedStatement pstmt = null;
        int parameterIndex = 1;

        try {

            StringBuffer query = new StringBuffer();

            query.append("INSERT INTO TB_USR_LOG (           ").append("\n");
            query.append("       LOG_SEQ                     ").append("\n");
            query.append("     , SYSTEM_TYPE                 ").append("\n");
            query.append("     , USER_ID                     ").append("\n");
            query.append("     , LOG_TYPE                    ").append("\n");
            query.append("     , LOG_DATE                    ").append("\n");
            query.append("     , LOG_DATETIME                ").append("\n");
            query.append("     , CLIENT_IP                   ").append("\n");
            query.append("     , SERVER_IP                   ").append("\n");
            query.append("     , REFERER_URL                 ").append("\n");
            query.append("     , SERVLET_PATH                ").append("\n");
            query.append("     , ERROR_YN                    ").append("\n");
            query.append("     , ERROR_MSG                   ").append("\n");
            query.append(") VALUES (                         ").append("\n");
            query.append("       SQ_LOG_SEQ.NEXTVAL          ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD')").append("\n");
            query.append("     , SYSDATE                     ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append("     , ?                           ").append("\n");
            query.append(")                                  ").append("\n");

            pstmt = this.nsr.getConnection().prepareStatement(query.toString());

            pstmt.setString(parameterIndex++, data.getString("SYSTEM_TYPE"));
            pstmt.setString(parameterIndex++, data.getString("USER_ID"));
            pstmt.setString(parameterIndex++, data.getString("LOG_TYPE"));
            pstmt.setString(parameterIndex++, data.getString("CLIENT_IP"));
            pstmt.setString(parameterIndex++, data.getString("SERVER_IP"));
            pstmt.setString(parameterIndex++, data.getString("REFERER_URL"));
            pstmt.setString(parameterIndex++, data.getString("SERVLET_PATH"));
            pstmt.setString(parameterIndex++, data.getString("ERROR_YN"));
            pstmt.setString(parameterIndex++, data.getString("ERROR_MSG"));

            return pstmt.executeUpdate();

        } catch (SQLException se) {
            throw new NSysException(se);
        } catch (RuntimeException rte) {
            throw new NSysException(rte);
        } finally {
            this.nsr.close(pstmt);
        }
    }
}
