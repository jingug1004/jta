package anyfive.ipims.patent.systemmgt.menugroup.groupuser.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class GroupUserDao extends NAbstractServletDao
{
    public GroupUserDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그룹별 사용자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupUserList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        if (xReq.getParam("SYSTEM_TYPE").equals("PATENT")) {
            dao.setQuery("/ipims/patent/systemmgt/menugroup/groupuser", "/retrievePatentGroupUserList");
        } else {
            dao.setQuery("/ipims/patent/systemmgt/menugroup/groupuser", "/retrieveOfficeGroupUserList");
        }
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 그룹별 사용자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createGroupUser(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupuser", "/createGroupUser");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그룹별 사용자 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] deleteGroupUserList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupuser", "/deleteGroupUserList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_groupUserList"));
    }
}
