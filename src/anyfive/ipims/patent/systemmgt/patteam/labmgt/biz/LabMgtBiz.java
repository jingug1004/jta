package anyfive.ipims.patent.systemmgt.patteam.labmgt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.labmgt.dao.LabMgtDao;

public class LabMgtBiz extends NAbstractServletBiz
{
    public LabMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연구소정보관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLabMgtList(AjaxRequest xReq) throws NException
    {
        LabMgtDao dao = new LabMgtDao(this.nsr);

        return dao.retrieveLabMgtList(xReq);
    }

    /**
     * 연구소정보관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createLabMgt(AjaxRequest xReq) throws NException
    {
        LabMgtDao dao = new LabMgtDao(this.nsr);

        if (dao.createLabMgt(xReq) == 0){
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

    }

    /**
     * 연구소정보관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLabMgt(AjaxRequest xReq) throws NException
    {
        LabMgtDao dao = new LabMgtDao(this.nsr);

        return dao.retrieveLabMgt(xReq);
    }

    /**
     * 연구소정보관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateLabMgt(AjaxRequest xReq) throws NException
    {
        LabMgtDao dao = new LabMgtDao(this.nsr);
        dao.updateLabMgt(xReq);
    }

    /**
     * 연구소정보관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteLabMgt(AjaxRequest xReq) throws NException
    {
        LabMgtDao dao = new LabMgtDao(this.nsr);
        dao.deleteLabMgt(xReq);
    }
}
