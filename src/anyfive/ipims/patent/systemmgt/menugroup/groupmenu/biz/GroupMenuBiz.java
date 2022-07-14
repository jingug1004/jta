package anyfive.ipims.patent.systemmgt.menugroup.groupmenu.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.groupmenu.dao.GroupMenuDao;

public class GroupMenuBiz extends NAbstractServletBiz
{
    public GroupMenuBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그룹별 메뉴 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupMenuList(AjaxRequest xReq) throws NException
    {
        GroupMenuDao dao = new GroupMenuDao(this.nsr);

        return dao.retrieveGroupMenuList(xReq);
    }

    /**
     * 그룹별 메뉴 목록 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateGroupMenuList(AjaxRequest xReq) throws NException
    {
        GroupMenuDao dao = new GroupMenuDao(this.nsr);

        NMultiData menuList = xReq.getMultiData("ds_groupMenuList");
        NMultiData createList = new NMultiData();
        NMultiData deleteList = new NMultiData();

        for (int i = 0; i < menuList.getRowSize(); i++) {
            if (menuList.getString(i, "JOB_TYPE").equals("C")) {
                createList.addSingleData(menuList.getSingleData(i));
            }
            if (menuList.getString(i, "JOB_TYPE").equals("D")) {
                deleteList.addSingleData(menuList.getSingleData(i));
            }
        }

        dao.deleteGroupMenuList(xReq, deleteList);
        dao.createGroupMenuList(xReq, createList);
    }
}
