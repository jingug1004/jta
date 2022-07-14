package anyfive.ipims.patent.applymgt.intpatent.conveyprint.biz;

import any.core.config.NConfig;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.intpatent.conveyprint.dao.IntPatentConveyPrintDao;

public class IntPatentConveyPrintBiz extends NAbstractServletBiz
{
    public IntPatentConveyPrintBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 양도증인쇄 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConveyPrintList(AjaxRequest xReq) throws NException
    {
        IntPatentConveyPrintDao dao = new IntPatentConveyPrintDao(this.nsr);

        return dao.retrieveIntPatentConveyPrintList(xReq);
    }

    /**
     * 양도증인쇄 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntPatentConveyPrint(AjaxRequest xReq) throws NException
    {
        IntPatentConveyPrintDao dao = new IntPatentConveyPrintDao(this.nsr);

        NSingleData result = new NSingleData();

        NSingleData mainInfo = dao.retrieveIntPatentConveyPrintMain(xReq);

        mainInfo.setString("COMPANY_NAME", NConfig.getString("/config/company-info/name"));
        mainInfo.setString("COMPANY_ADDRESS", NConfig.getString("/config/company-info/address"));

        result.set("ds_conveyPrintMain", mainInfo);
        result.set("ds_conveyPrintInventor", dao.retrieveIntPatentConveyPrintInventor(xReq));
        result.set("ds_conveyPrintInventorTop", dao.retrieveIntPatentConveyPrintInventorTop(xReq));

        return result;
    }
}
