package anyfive.ipims.patent.schedule.slipif.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.schedule.slipif.dao.ExecuteSlipIFDao;

public class ExecuteSlipIFBiz extends NAbstractServletBiz
{
    public ExecuteSlipIFBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 전표 정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateSlipInfo() throws NException
    {
        ExecuteSlipIFDao dao = new ExecuteSlipIFDao(this.nsr);

        String slipId = null;
        String accountSlipNo = null;
        String accountProcUser = null;

        NMultiData ErpSlipInfo = dao.retriveErpSlipInfo();

        for (int i = 0; i < ErpSlipInfo.getRowSize(); i ++) {
            slipId = ErpSlipInfo.getString(i, "SLIP_ID");
            accountSlipNo = ErpSlipInfo.getString(i, "ACCOUNT_SLIP_NO");
            accountProcUser = ErpSlipInfo.getString(i, "ACCOUNT_PROC_USER");

            dao.updateSlipInfo(slipId, accountSlipNo, accountProcUser);

            dao.updateErpSlip(slipId);
        }
    }
}


