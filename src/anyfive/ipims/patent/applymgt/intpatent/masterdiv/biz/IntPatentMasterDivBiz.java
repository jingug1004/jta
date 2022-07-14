package anyfive.ipims.patent.applymgt.intpatent.masterdiv.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.masterdiv.dao.IntPatentMasterDivDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.inventor.biz.InventorMappBiz;
import anyfive.ipims.patent.common.mapping.prsch.biz.PrschMappBiz;
import anyfive.ipims.patent.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.docpaper.common.biz.DocPaperCommonBiz;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class IntPatentMasterDivBiz extends NAbstractServletBiz
{
    public IntPatentMasterDivBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국내분할 모출원 서지사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentMasterDivPrior(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDivDao dao = new IntPatentMasterDivDao(this.nsr);

        NSingleData result = new NSingleData();

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveIntPatentMasterDivPrior(xReq.getParam("DIVISION_PRIOR_REF_ID"));
        result.set("ds_priorInfo", priorInfo);

        return result;
    }

    /**
     * 국내분할 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createIntPatentMasterDiv(AjaxRequest xReq) throws NException
    {
        IntPatentMasterDivDao dao = new IntPatentMasterDivDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        DocPaperCommonBiz docBiz = new DocPaperCommonBiz(this.nsr);

        String divisionPriorRefId = xReq.getParam("DIVISION_PRIOR_REF_ID");
        String divisionCode = this.getDivisionCode(xReq, dao);
        String refId = seqUtil.getBizId();

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveIntPatentMasterDivPrior(divisionPriorRefId);

        String refNo = priorInfo.getString("REF_NO") + divisionCode;

        // 데이터 준비
        xReq.setUserData("REF_ID", refId);
        xReq.setUserData("REF_NO", priorInfo.getString("REF_NO") + divisionCode);
        xReq.setUserData("DIVISION_CODE", divisionCode);

        // 국내마스터 생성
        dao.createIntPatentMaster(xReq);

        // 국내출원품의서 생성
        if (dao.createIntPatentConsult(xReq) == 0) {
            dao.createIntPatentConsultByMaster(xReq);
        }

        // 발명자 맵핑목록 복제
        InventorMappBiz invBiz = new InventorMappBiz(this.nsr);
        invBiz.duplicateInventorList(divisionPriorRefId, refId);

        // 기술분류코드 맵핑목록 복제
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        techBiz.duplicateTechCodeList(divisionPriorRefId, MappingDiv.NONE, refId, MappingDiv.NONE);

        // 선행조사 맵핑목록 복제
        PrschMappBiz prschBiz = new PrschMappBiz(this.nsr);
        prschBiz.duplicatePrschList(divisionPriorRefId, MappingDiv.NONE, refId, MappingDiv.NONE);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(refId, WorkProcessConst.Step.INT_PATENT_CONSULT);

        // 모출원건에 분할출원 진행서류 생성
        docBiz.init(priorInfo.getString("REF_ID"));
        if(xReq.getSingleData("ds_mainInfo").getString("DIVISION_TYPE").equals("P"))
            docBiz.setEvent("INT_MASTER_PRIOR_PARENT");
        else
            docBiz.setEvent("INT_MASTER_DIV_PARENT");
        docBiz.setValue("PAPER_REF_NO", refNo);
        docBiz.setValue("COMMENTS", divisionCode);
        docBiz.create();

        // 자출원건에 직무발명신고서접수 진행서류 생성
        docBiz.init(refId);
        docBiz.setEvent("INT_MASTER_DIV_CHILD");
        docBiz.setValue("PAPER_REF_NO", priorInfo.getString("REF_NO"));
        docBiz.create();

        return refId;
    }

    /**
     * 분할코드 반환
     *
     * @param xReq
     * @param dao
     * @return
     * @throws NException
     */
    private String getDivisionCode(AjaxRequest xReq, IntPatentMasterDivDao dao) throws NException
    {
        String divisionType = xReq.getSingleData("ds_mainInfo").getString("DIVISION_TYPE");

        // 국내분할 분할코드 조회
        String divisionCode = dao.retrieveIntPatentMasterDivDivisionCode(xReq);

        int divisionLevel;

        if (divisionCode.equals("") == true) {
            divisionLevel = 1;
        } else {
            try {
                divisionLevel = Integer.parseInt(divisionCode.substring(1), 10) + 1;
            } catch (NumberFormatException e) {
                throw new NBizException("분할코드 생성 오류!");
            }
            if (divisionLevel > 2) {
                throw new NBizException("더 이상 분할할 수 없습니다.");
            }
        }

        return (divisionType + Integer.toString(divisionLevel)).substring(0, 2);
    }
}
