package anyfive.ipims.patent.costmgt.annual.payment.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualPaymentDao extends NAbstractServletDao
{
    public AnnualPaymentDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차료 납부관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualPaymentList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/retrieveAnnualPaymentList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 연차료구분
        if (xReq.getParam("ANNUAL_DIV").equals("") != true) {
            dao.addQuery("annualDiv");
        }

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        // 발명의명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("koAppTitle");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 비용 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/createCostMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연차료 비용 생성
     *
     * @param data
     * @return
     * @throws NException
     */
    public int createAnnualPayment(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/createAnnualPayment");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 비용 마스터 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateCostMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updateCostMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연차료 비용 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateAnnualPayment(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updateAnnualPayment");
        dao.bind(xReq);

        return dao.executeUpdate();
    }




    /** 2010.10.26 생상  */

    /**
     * 수수료비용 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createOfficeChargeMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/createOfficeChargeMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외송금비용 마스터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtChargeMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/createExtChargeMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 관납비용 마스터 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updatePriceCostMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updatePriceCostMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 수수료비용 마스터 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateOfficeChargeMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updateOfficeChargeMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외송금비용 마스터 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateExtChargeMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updateExtChargeMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 총항수 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createCostReminde(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/createCostReminde");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 총항수 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateCostReminde(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/payment", "/updateCostReminde");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
