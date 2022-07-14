package anyfive.framework.codedata.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class CodeDataDao extends NAbstractServletDao
{
    public CodeDataDao(NServiceResource nsr)
    {
        super(nsr);
    }

    public NMultiData retrieveQryCodeData(AjaxRequest xReq, String path) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        String[] pathArray = path.split(",");

        dao.setCodeDataQuery(pathArray[0]);
        dao.bind(xReq);

        for (int i = 1; i < pathArray.length; i++) {
            if (pathArray[i].indexOf("||") == -1) {
                dao.bind(Integer.toString(i), pathArray[i].trim());
            } else {
                dao.bind(Integer.toString(i), pathArray[i].trim().split("\\|\\|"));
            }
        }

        return dao.executeQuery();
    }
}
