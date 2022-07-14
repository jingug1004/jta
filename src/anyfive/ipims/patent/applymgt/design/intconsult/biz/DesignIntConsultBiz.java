package anyfive.ipims.patent.applymgt.design.intconsult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intconsult.dao.DesignIntConsultDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class DesignIntConsultBiz extends NAbstractServletBiz
{
    public DesignIntConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntConsultList(AjaxRequest xReq) throws NException
    {
        DesignIntConsultDao dao = new DesignIntConsultDao(this.nsr);

        return dao.retrieveDesignIntConsultList(xReq);
    }

    /**
     * 디자인국내출원품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntConsult(AjaxRequest xReq) throws NException
    {
        DesignIntConsultDao dao = new DesignIntConsultDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내디자인 출원의뢰
        result.set("ds_mainInfo", dao.retrieveDesignIntConsult(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 출원예상국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(refId, MappingDiv.NONE));

        // 출원인 맵핑 목록 조회
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 디자인국내출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateDesignIntConsult(AjaxRequest xReq) throws NException
    {
        DesignIntConsultDao dao = new DesignIntConsultDao(this.nsr);

        // REF_ID 시퀀스 생성
        String refId = xReq.getParam("REF_ID");

        dao.updateDesignIntConsult(xReq);

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.WRITE, true);

    }
}
