package anyfive.ipims.patent.systemmgt.basecode.countrymgt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.countrymgt.dao.CountryCodeMgtDao;

public class CountryCodeMgtBiz extends NAbstractServletBiz
{
    public CountryCodeMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 국가코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCountryCodeMgtList(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        return dao.retrieveCountryCodeMgtList(xReq);
    }

    /**
     * 국가코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        return dao.retrieveCountryCodeMgt(xReq);
    }

    /**
     * 국가코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        dao.createCountryCodeMgt(xReq);
    }

    /**
     * 국가코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        dao.updateCountryCodeMgt(xReq);
    }

    /**
     * 국가코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteCountryCodeMgt(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        dao.deleteCountryCodeMgt(xReq);
    }

    /**
     * 국가코드 정렬순서 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateCountryDispOrdList(AjaxRequest xReq) throws NException
    {
        CountryCodeMgtDao dao = new CountryCodeMgtDao(this.nsr);

        dao.updateCountryDispOrdList(xReq);
    }
}
