package anyfive.ipims.patent.home.dao;

import java.util.ArrayList;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PatentDao extends NAbstractServletDao
{
    public PatentDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허보유현황 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrievePatentCountList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        ArrayList<String> queryList = new ArrayList<String>();

        queryList.add("ALL");
        queryList.add("REG");
        queryList.add("APP");

        dao.setQuery("/ipims/patent/home/patent", "/retrievePatentCountList");
        dao.bind(xReq);

        for (int i = 0; i < queryList.size(); i++) {
            if (i > 0)dao.addQuery("union");
            dao.replaceText("ID", queryList.get(i));
            dao.replaceQuery("LIST_QUERY", "/retrievePatentCountList_" + queryList.get(i));
        }

        return dao.executeQuery();
    }
}
