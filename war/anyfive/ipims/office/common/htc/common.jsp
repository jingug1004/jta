<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
ANY\:INV {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/inventor.htc");
}

ANY\:PJT {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/project.htc");
}

ANY\:ABSTRACT {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/abstractinfo.htc");
}

ANY\:COSTSEARCH {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/costsearch.htc");
}

ANY\:PRIORAPP {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/priorapp.htc");
}

ANY\:OLCOUNTRY {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/olcountry.htc");
}

ANY\:OTHERINFO {
    behavior: url("<%= request.getContextPath() %>/anyfive/ipims/office/common/htc/common/otherinfo.htc");
}
