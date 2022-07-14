package anyfive.ipims.patent.ipbiz.contract.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ContractDao extends NAbstractServletDao
{
    public ContractDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 계약서 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveContractList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/contract", "/retrieveContractList");
        dao.bind(xReq);


            // 관리번호
            if (xReq.getParam("MGT_ID").equals("") != true) {
                dao.addQuery("mgtId");
            }

            // 계약서종류
            if (xReq.getParam("CONTRACT_KIND").equals("") != true) {
                dao.addQuery("contractKind");
            }

            // 상대방 명칭
            if (xReq.getParam("OTHER_TITLE").equals("") != true) {
                dao.addQuery("otherTitle");
            }

            // 심의위원
            if (xReq.getParam("COUNTRY").equals("") != true) {
                dao.addQuery("country");
            }
        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 계약서  생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createContractC(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        dao.setQuery("/ipims/patent/ipbiz/contract", "/createContractC");
        dao.bind(xReq);
        dao.executeUpdate();

    }

    /**
     * 계약서 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveContractRD(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/contract", "/retrieveContractRD");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 계약서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateContractU(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/contract", "/updateContractU");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 계약서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteContract(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/ipbiz/contract", "/deleteContract");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

}
