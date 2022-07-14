package anyfive.ipims.patent.applymgt.docpaper.docpaperlist.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.docpaper.docpaperlist.dao.DocPaperListDao;

public class DocPaperListBiz extends NAbstractServletBiz
{
    public DocPaperListBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperList(AjaxRequest xReq) throws NException
    {
        DocPaperListDao dao = new DocPaperListDao(this.nsr);

        return dao.retrieveDocPaperList(xReq);
    }
}
