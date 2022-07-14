package anyfive.ipims.patent.applymgt.design.intreceipt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.design.intreceipt.dao.DesignIntReceiptDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class DesignIntReceiptBiz extends NAbstractServletBiz
{
    public DesignIntReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인국내의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntReceiptList(AjaxRequest xReq) throws NException
    {
        DesignIntReceiptDao dao = new DesignIntReceiptDao(this.nsr);

        return dao.retrieveDesignIntReceiptList(xReq);
    }

    /**
     * 디자인국내의뢰접수 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignIntReceipt(AjaxRequest xReq) throws NException
    {
        DesignIntReceiptDao dao = new DesignIntReceiptDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내디자인 출원의뢰
        result.set("ds_mainInfo", dao.retrieveDesignIntReceipt(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 출원예상국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 디자인국내의뢰접수 건담당자지정
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void updateDesignIntReceiptJobMan(String refId, String jobMan) throws NException
    {
        DesignIntReceiptDao dao = new DesignIntReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        // 디자인국내출원품의 생성
        dao.createDesignIntConsult(refId, jobMan);

        // 디자인국내출원마스터 생성
        dao.createDesignIntMaster(refId, jobMan);

        // 보상금 내역 저장
        rewardBiz.init(refId);
        rewardBiz.setValue("REWARD_GIVETARGET_YN", "1");
        rewardBiz.update("APP");
        rewardBiz.update("REG");

        // 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("PATTEAM_RECEIPT");
        docBiz.create();

        // 업무프로세스-> 특허팀접수완료
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(refId, WorkProcessConst.Action.JOB_MAN_ASSIGN);
    }
}
