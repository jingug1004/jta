package anyfive.ipims.patent.applymgt.tmark.intconsult.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intconsult.dao.TMarkIntConsultDao;
import anyfive.ipims.patent.common.mapping.appmc.biz.AppManCodeMappBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.tmarkcls.biz.TMarkClsMappBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class TMarkIntConsultBiz extends NAbstractServletBiz
{
    public TMarkIntConsultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntConsultList(AjaxRequest xReq) throws NException
    {
        TMarkIntConsultDao dao = new TMarkIntConsultDao(this.nsr);

        return dao.retrieveTMarkIntConsultList(xReq);
    }

    /**
     * 상표국내출원품의 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntConsult(AjaxRequest xReq) throws NException
    {
        TMarkIntConsultDao dao = new TMarkIntConsultDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 상표국내출원품의 조회
        result.set("ds_mainInfo", dao.retrieveTMarkIntConsult(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 상품류 맵핑목록 조회
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        result.set("ds_tmarkClsList", tmarkBiz.retrieveTMarkClsList(refId, MappingDiv.NONE));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(refId, MappingDiv.NONE));

        // 출원인 맵핑 목록 조회
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        result.set("ds_appManCodeList", appmc.retrieveAppManCodeList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 상표국내출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntConsult(AjaxRequest xReq) throws NException
    {
        TMarkIntConsultDao dao = new TMarkIntConsultDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 상표국내출원품의 수정
        dao.updateTMarkIntConsult(xReq);

        // 상품류 맵핑목록 저장
        TMarkClsMappBiz tmarkBiz = new TMarkClsMappBiz(this.nsr);
        tmarkBiz.updateTMarkClsList(refId, MappingDiv.NONE, xReq.getMultiData("ds_tmarkClsList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 출원인 맵핑 저장
        AppManCodeMappBiz appmc = new AppManCodeMappBiz(this.nsr);
        appmc.updateAppManCodeList(refId, MappingDiv.NONE, xReq.getMultiData("ds_appManCodeList"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.WRITE, true);
    }
}
