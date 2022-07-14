package anyfive.ipims.patent.systemmgt.officemgt.main.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.officemgt.main.dao.OfficeMgtMainDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class OfficeMgtMainBiz extends NAbstractServletBiz
{
    public OfficeMgtMainBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtMainList(AjaxRequest xReq) throws NException
    {
        OfficeMgtMainDao dao = new OfficeMgtMainDao(this.nsr);

        return dao.retrieveOfficeMgtMainList(xReq);
    }

    /**
     * 사무소 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        OfficeMgtMainDao dao = new OfficeMgtMainDao(this.nsr);

        return dao.retrieveOfficeMgtMain(xReq);
    }

    /**
     * 사무소 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        OfficeMgtMainDao dao = new OfficeMgtMainDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String officeCode = seqUtil.getOfficeCode();

        xReq.setUserData("OFFICE_CODE", officeCode);

        dao.createOfficeMgtMain(xReq);

        return officeCode;
    }

    /**
     * 사무소 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        OfficeMgtMainDao dao = new OfficeMgtMainDao(this.nsr);

        dao.updateOfficeMgtMain(xReq);
    }

    /**
     * 사무소 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteOfficeMgtMain(AjaxRequest xReq) throws NException
    {
        OfficeMgtMainDao dao = new OfficeMgtMainDao(this.nsr);

        if (dao.deleteOfficeMgtMain(xReq) == 0) {
            throw new NBizException("사무소를 삭제할 수 없습니다.");
        }
    }
}
