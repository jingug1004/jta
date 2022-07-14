package anyfive.ipims.patent.applymgt.tmark.intrequest.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.patent.applymgt.tmark.intrequest.dao.TMarkIntRequestDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class TMarkIntRequestBiz extends NAbstractServletBiz
{
    public TMarkIntRequestBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표국내출원의뢰 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntRequestList(AjaxRequest xReq) throws NException
    {
        TMarkIntRequestDao dao = new TMarkIntRequestDao(this.nsr);

        return dao.retrieveTMarkIntRequestList(xReq);
    }

    /**
     * 상표국내출원의뢰 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        TMarkIntRequestDao dao = new TMarkIntRequestDao(this.nsr);

        String refId = xReq.getParam("REF_ID");

        NSingleData result = new NSingleData();

        // 국내상표 출원의뢰 조회
        result.set("ds_mainInfo", dao.retrieveTMarkIntRequest(xReq));

        // 발명자 맵핑목록 조회
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        result.set("ds_inventorList", invBiz.retrieveInventorList(refId));

        // 선행조사 맵핑목록 조회
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        result.set("ds_prschList", prschBiz.retrievePrschList(refId, MappingDiv.NONE));

        return result;
    }

    /**
     * 상표국내출원의뢰 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        TMarkIntRequestDao dao = new TMarkIntRequestDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = seqUtil.getBizId();

        // 데이터준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", seqUtil.getRefGrpNo("40"));
        xReq.setUserData("DIVISN_CODE", SessionUtil.getUserInfo(this.nsr).getDivisnCode());
        xReq.setUserData("DEPT_CODE", SessionUtil.getUserInfo(this.nsr).getDeptCode());

        // 상표국내출원의뢰 생성
        dao.createTMarkIntRequest(xReq);

        // 발명자 맵핑목록 생성
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 상표이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_tmarkImgFile"));

        // 기타자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.INT_TMARK_REQUEST);

        return refId;
    }

    /**
     * 상표국내출원의뢰 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        TMarkIntRequestDao dao = new TMarkIntRequestDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String refId = xReq.getParam("REF_ID");

        // 상표국내출원의뢰 수정
        dao.updateTMarkIntRequest(xReq);

        // 발명자 맵핑목록 수정
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.updateInventorList(refId, xReq.getMultiData("ds_inventorList"));

        // 선행조사 맵핑목록 저장
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.updatePrschList(refId, MappingDiv.NONE, xReq.getMultiData("ds_prschList"));

        // 상표이미지 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_tmarkImgFile"));

        // 기타자료 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_etcFile"));
    }

    /**
     * 상표국내출원의뢰 재작성(보완요청 확인)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void rewriteTMarkIntRequest(AjaxRequest xReq) throws NException
    {
        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("REF_ID"), WorkProcessConst.Action.REWRITE);
    }
}
