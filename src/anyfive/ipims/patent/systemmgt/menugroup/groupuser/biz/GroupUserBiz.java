package anyfive.ipims.patent.systemmgt.menugroup.groupuser.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.groupuser.dao.GroupUserDao;

public class GroupUserBiz extends NAbstractServletBiz
{
    public GroupUserBiz(NServiceResource nsr)
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
        GroupUserDao dao = new GroupUserDao(this.nsr);

        return dao.retrieveGroupUserList(xReq);
    }

    /**
     * 그룹별 사용자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createGroupUser(AjaxRequest xReq) throws NException
    {
        GroupUserDao dao = new GroupUserDao(this.nsr);

        dao.createGroupUser(xReq);
    }

    /**
     * 그룹별 사용자 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteGroupUserList(AjaxRequest xReq) throws NException
    {
        GroupUserDao dao = new GroupUserDao(this.nsr);

        dao.deleteGroupUserList(xReq);
    }
}
