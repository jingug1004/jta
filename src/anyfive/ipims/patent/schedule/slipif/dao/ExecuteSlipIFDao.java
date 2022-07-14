package anyfive.ipims.patent.schedule.slipif.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ExecuteSlipIFDao extends NAbstractServletDao
{
    public ExecuteSlipIFDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 전표 정보 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveSlipInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/slip", "/retrieveAssetInfo");

        return dao.executeQuery();
    }

    public NMultiData retriveErpSlipInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/slip", "/retrieveSlipInfo");
        return dao.executeQuery();
    }

    /**
     * 전표 정보 수정
     *
     * @return
     * @throws NException
     */
    public void updateSlipInfo(String slipId, String accountSlipNo, String accountProcUser) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/slip", "/updateSlipInfo");
        dao.bind("SLIP_ID", slipId);
        dao.bind("ACCOUNT_SLIP_NO", accountSlipNo);
        dao.bind("ACCOUNT_PROC_USER", accountProcUser);
        dao.executeUpdate();
    }

    /**
     *  ERP 전표처리 완료 및 비용 완료처리
     *
     * @param slipId
     * @throws NException
     */
    public void updateErpSlip(String slipId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/slip", "/updateErpSlip");
        dao.bind("SLIP_ID", slipId);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/schedule/slip", "/updateCostMasterSlipStatus");
        dao.bind("SLIP_ID", slipId);
        dao.executeUpdate();
    }

}
