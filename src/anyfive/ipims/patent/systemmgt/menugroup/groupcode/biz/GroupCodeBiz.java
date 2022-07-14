package anyfive.ipims.patent.systemmgt.menugroup.groupcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.groupcode.dao.GroupCodeDao;

public class GroupCodeBiz extends NAbstractServletBiz
{
    public GroupCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그룹관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupCodeList(AjaxRequest xReq) throws NException
    {
        GroupCodeDao dao = new GroupCodeDao(this.nsr);

        return dao.retrieveGroupCodeList(xReq);
    }

    /**
     * 그룹관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupCode(AjaxRequest xReq) throws NException
    {
        GroupCodeDao dao = new GroupCodeDao(this.nsr);

        return dao.retrieveGroupCode(xReq);
    }

    /**
     * 그룹관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createGroupCode(AjaxRequest xReq) throws NException
    {
        GroupCodeDao dao = new GroupCodeDao(this.nsr);

        dao.createGroupCode(xReq);
        dao.createGroupCommonMenu(xReq);
    }

    /**
     * 그룹관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateGroupCode(AjaxRequest xReq) throws NException
    {
        GroupCodeDao dao = new GroupCodeDao(this.nsr);

        dao.updateGroupCode(xReq);
    }

    /**
     * 그룹관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteGroupCode(AjaxRequest xReq) throws NException
    {
        GroupCodeDao dao = new GroupCodeDao(this.nsr);

        dao.deleteGroupMenuList(xReq);
        dao.deleteGroupUserList(xReq);
        dao.deleteGroupCode(xReq);
    }
}
