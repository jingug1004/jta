package anyfive.ipims.office.reqreceipt.priorsearch.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NTextUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.office.common.mapping.consts.MappingDiv;
import anyfive.ipims.office.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.office.common.mapping.project.biz.ProjectMappBiz;
import anyfive.ipims.office.common.mapping.tech.biz.TechCodeMappBiz;
import anyfive.ipims.office.reqreceipt.priorsearch.dao.PriorSearchReceiptDao;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchReceiptBiz extends NAbstractServletBiz
{
    public PriorSearchReceiptBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 조사의뢰접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchReceiptList(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        return dao.retrievePriorSearchReceiptList(xReq);
    }

    /**
     * 조사의뢰접수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchReceipt(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        String prschId = xReq.getParam("PRSCH_ID");

        NSingleData result = new NSingleData();

        // 조사의뢰접수 조회
        result.set("ds_mainInfo", dao.retrievePriorSearchReceipt(xReq));

        // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(prschId, MappingDiv.NONE));

        // 조사국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(prschId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록 조회
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(prschId, MappingDiv.NONE));

        return result;
    }

    /**
     * 조사의뢰접수 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchReceipt(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        String prschId = xReq.getParam("PRSCH_ID");

        // 국내출원의뢰접수 저장
        dao.updatePriorSearchReceipt(xReq);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(prschId, WorkProcessConst.Action.OFFICE_RECEIPT, true);
    }

    /**
     * 조사의뢰결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchResult(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);

        String prschId = xReq.getParam("PRSCH_ID");

        NSingleData result = new NSingleData();

        // 조사의뢰접수 조회
        result.set("ds_mainInfo", dao.retrievePriorSearchResult(xReq));

        // 프로젝트 맵핑목록 조회
        ProjectMappBiz pjtBiz = new ProjectMappBiz(this.nsr);
        result.set("ds_projectList", pjtBiz.retrieveProjectList(prschId, MappingDiv.NONE));

        // 조사국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(prschId, MappingDiv.NONE));

        // 기술분류코드 맵핑목록 조회
        TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        result.set("ds_techCodeList", techBiz.retrieveTechCodeList(prschId, MappingDiv.NONE));

        return result;
    }

    /**
     * 조사의뢰결과 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchResult(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 조사의뢰결과 수정
        if (dao.updatePriorSearchResult(xReq) == 0) {
            // 조사의뢰결과 생성
            dao.createPriorSearchResult(xReq);

            // 업무프로세스
            WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
            wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.PRSCH_RESULT_INPUT);
        }

        // 조사결과관련 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_resultFile"));
    }

    /**
     * 조사결과 완료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchComplete(AjaxRequest xReq) throws NException
    {
        PriorSearchReceiptDao dao = new PriorSearchReceiptDao(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        // 조사결과 완료
        dao.updatePriorSearchComplete(xReq);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.PRSCH_RESULT_COMPLETE);

        // 조사결과 통보메일 발송정보 조회
        NSingleData mailInfo = dao.retrievePriorSearchInformMailInfo(xReq);

        // 조사결과 통보메일 발송
        mail.init();
        mail.template.init("/prsch/inform");
        mail.template.setData(mailInfo);
        mail.setSubject(NTextUtil.crop(mail.template.toString(), "<TITLE>", "</TITLE>"));
        mail.addTo(mailInfo.getString("TO_ADDR"), mailInfo.getString("TO_NAME"));
        mail.create();
    }
}
