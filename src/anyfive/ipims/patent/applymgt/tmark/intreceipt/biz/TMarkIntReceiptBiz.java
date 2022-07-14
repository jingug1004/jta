package anyfive.ipims.patent.applymgt.tmark.intreceipt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.tmark.intreceipt.dao.TMarkIntReceiptDao;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.reward.biz.RewardBiz;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class TMarkIntReceiptBiz extends NAbstractServletBiz
{
    public TMarkIntReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntReceiptList(AjaxRequest xReq) throws NException
    {
        TMarkIntReceiptDao dao = new TMarkIntReceiptDao(this.nsr);

        return dao.retrieveTMarkIntReceiptList(xReq);
    }

    /**
     * 상표국내출원의뢰 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntReceipt(AjaxRequest xReq) throws NException
    {
        TMarkIntReceiptDao dao = new TMarkIntReceiptDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내상표 출원의뢰
        result.set("ds_mainInfo", dao.retrieveTMarkIntReceipt(xReq));

        // 발명자 맵핑목록
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        return result;
    }

    /**
     * 상표국내출원접수 건담당자지정
     *
     * @param refId
     * @param jobMan
     * @throws NException
     */
    public void updateTMarkIntReceiptJobMan(String refId, String jobMan) throws NException
    {
        TMarkIntReceiptDao dao = new TMarkIntReceiptDao(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);
        RewardBiz rewardBiz = new RewardBiz(this.nsr);

        // 상표국내출원품의 생성
        dao.createTMarkIntConsult(refId, jobMan);

        // 상표국내출원마스터 생성
        dao.createTMarkIntMaster(refId, jobMan);

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
