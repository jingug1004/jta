package anyfive.ipims.patent.ipbiz.license.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.country.biz.CountryMappBiz;
import anyfive.ipims.patent.ipbiz.history.biz.IpBizHistoryBiz;
import anyfive.ipims.patent.ipbiz.license.dao.LicenseDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class LicenseBiz extends NAbstractServletBiz
{
    public LicenseBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 라이센스 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLicenseList(AjaxRequest xReq) throws NException
    {
        LicenseDao dao = new LicenseDao(this.nsr);

        return dao.retrieveLicenseList(xReq);
    }

    /**
     * 라이센스 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createLicense(AjaxRequest xReq) throws NException
    {
        LicenseDao dao = new LicenseDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String licenseId = seqUtil.getBizId();

        xReq.setUserData("LICENSE_ID", licenseId);
        xReq.setUserData("MGT_NO", seqUtil.getLicenseMgtNo());

        // 라이센스 생성
        dao.createLicense(xReq);

        // 분석자료 맵핑목록 저장
        //IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        //analyBiz.updateIpbAnalyList(licenseId, xReq.getMultiData("ds_analyList"));

        // 기술분류코드 맵핑목록 저장
        // TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        // techBiz.updateTechCodeList(licenseId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(licenseId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return licenseId;
    }

    /**
     * 라이센스 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLicense(AjaxRequest xReq) throws NException
    {
        LicenseDao dao = new LicenseDao(this.nsr);

        NSingleData result = new NSingleData();

        String licenseId = xReq.getParam("LICENSE_ID");

        // 라이센스 조회
        result.set("ds_mainInfo", dao.retrieveLicense(xReq));

        // 분석자료 맵핑목록 조회
        //IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        //result.set("ds_analyList", analyBiz.retrieveIpbAnalyList(licenseId));

        // 기술분류코드 맵핑목록 조회
        // TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        // result.set("ds_techCodeList", techBiz.retrieveTechCodeList(licenseId, MappingDiv.NONE));

        // 국가 맵핑목록 조회
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        result.set("ds_countryList", countryBiz.retrieveCountryList(licenseId, MappingDiv.NONE));

        return result;
    }

    /**
     * 라이센스 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateLicense(AjaxRequest xReq) throws NException
    {
        LicenseDao dao = new LicenseDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String licenseId = xReq.getParam("LICENSE_ID");

        // 라이센스 수정
        dao.updateLicense(xReq);

        // 분석자료 맵핑목록 저장
        //IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        //analyBiz.updateIpbAnalyList(licenseId, xReq.getMultiData("ds_analyList"));

        // 기술분류코드 맵핑목록 저장
        // TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        // techBiz.updateTechCodeList(licenseId, MappingDiv.NONE, xReq.getMultiData("ds_techCodeList"));

        // 국가 맵핑목록 저장
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.updateCountryList(licenseId, MappingDiv.NONE, xReq.getMultiData("ds_countryList"));

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 라이센스 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteLicense(AjaxRequest xReq) throws NException
    {
        LicenseDao dao = new LicenseDao(this.nsr);

        String licenseId = xReq.getParam("LICENSE_ID");

        NSingleData mainInfo = dao.retrieveLicense(xReq);

        // 분석자료 맵핑목록삭제
        //IpbAnalyMappBiz analyBiz = new IpbAnalyMappBiz(this.nsr);
        //analyBiz.deleteIpbAnalyListAll(licenseId);

        // 기술분류코드 맵핑목록삭제
        // TechCodeMappBiz techBiz = new TechCodeMappBiz(this.nsr);
        // techBiz.deleteTechCodeListAll(licenseId, MappingDiv.NONE);

        // 국가 맵핑 목록삭제
        CountryMappBiz countryBiz = new CountryMappBiz(this.nsr);
        countryBiz.deleteCountryListAll(licenseId, MappingDiv.NONE);

        // History 전체삭제
        IpBizHistoryBiz histBiz = new IpBizHistoryBiz(this.nsr);
        histBiz.deleteIpBizHistoryAll(licenseId);

        // 라이센스 삭제
        dao.deleteLicense(xReq);

        // 첨부파일 삭제
        FileBiz fileBiz = new FileBiz(this.nsr);
        fileBiz.deleteFileList(mainInfo.getString("ATTACH_FILE"));
    }
}
