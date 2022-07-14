package anyfive.ipims.patent.search.oursearch.util;

import java.util.ArrayList;

import m2.context.msg.protocol.Protocol;
import m2.context.msg.protocol.query.FilterSet;
import m2.context.msg.protocol.query.OrderBySet;
import m2.context.msg.protocol.query.Query;
import m2.context.msg.protocol.query.QueryParser;
import m2.context.msg.protocol.query.QuerySet;
import m2.context.msg.protocol.query.SelectSet;
import m2.context.msg.protocol.query.WhereSet;
import m2.context.msg.protocol.result.Result;
import m2.context.msg.protocol.result.ResultSet;
import m2.earth.command.CommandSearchRequest;
import m2.earth.util.EarthException;
import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;

public class OurSearchUtil
{
    public static String host = NConfig.getString("/config/our-search/host");
    public static int    port = NConfig.getInt("/config/our-search/port");

    public static ArrayList<String> getSearchResult(String searchTerm, int maxSize) throws EarthException
    {
        int currentPage = 1;
        int ROWSPERPAGE = maxSize;

        int totalResultSize = 0;

        Result result = null;
        Result[] resultlist = null;
        SelectSet[] selectSet = null;
        SelectSet[] getselectSet = null;

        // SelectSet
        if (searchTerm != null && !searchTerm.equals("")) {
            selectSet = new SelectSet[] {new SelectSet("ID", Protocol.SelectSet.NONE)};

            // WhereSet
            WhereSet[] whereSet = null;

            ArrayList<WhereSet> whereList = new ArrayList<WhereSet>();
            whereList.add(new WhereSet("TL", Protocol.WhereSet.OP_HASALL, searchTerm, 100));
            whereList.add(new WhereSet(Protocol.WhereSet.OP_OR));
            // whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
            whereList.add(new WhereSet("AB", Protocol.WhereSet.OP_HASALL, searchTerm, 10));
            whereList.add(new WhereSet(Protocol.WhereSet.OP_OR));
            whereList.add(new WhereSet("CL", Protocol.WhereSet.OP_HASALL, searchTerm, 1));
            // whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));

            whereSet = new WhereSet[whereList.size()];
            for (int i = 0; i < whereList.size(); i++) {
                whereSet[i] = whereList.get(i);
            }

            // OrderBySet
            OrderBySet[] orderbys = new OrderBySet[1];
            orderbys[0] = new OrderBySet(true, "weight", Protocol.OrderBySet.OP_PREWEIGHT);

            // FilterSet

            // QuerySet
            Query query = new Query();
            query.setFrom("search");

            query.setSearchOption(Protocol.SearchOption.CACHE);
            query.setSelect(selectSet);
            query.setWhere(whereSet);
            query.setOrderby(orderbys);
            // query.setFilter(filterSet);
            // query.setGroupBy(groups);
            // query.setQueryLogger("template");

            QueryParser queryParser = new QueryParser();
            String tmpProtocolStr = queryParser.queryToString(query);
            System.out.println("<!--protocolStr_query=" + tmpProtocolStr + "<br>-->");

            getselectSet = query.getSelectFields();

            int startnum = (currentPage - 1) * ROWSPERPAGE;
            int endnum = startnum + ROWSPERPAGE - 1;

            query.setResult(startnum, endnum);

            query.setValue("debug", "true");

            QuerySet querySet = new QuerySet(1);
            querySet.addQuery(query);

            CommandSearchRequest.setProps(host, port, 100000, 5, 5);
            CommandSearchRequest command = new CommandSearchRequest(host, port);

            // long start = System.currentTimeMillis();
            int rset = command.request(querySet);
            // long end = System.currentTimeMillis();

            if (rset >= 0) {
                ResultSet results = command.getResultSet();
                resultlist = results.getResultList();
            } else {
                resultlist = new Result[0];
            }
        } else {
            resultlist = new Result[0];
        }

        String selectFieldName = "";
        ArrayList<String> arrID = new ArrayList<String>();

        // ArrayList arrReturnValue = new ArrayList();
        for (int k = 0; resultlist != null && k < resultlist.length; k++) {
            result = resultlist[k];
            totalResultSize = result.getTotalSize();

            if (result != null && totalResultSize > 0) {

                for (int i = 0; i < result.getRealSize(); i++) {
                    String ID = "";

                    // String[] display_value = new String[result.getNumField()];
                    for (int m = 0; m < result.getNumField(); m++) {
                        selectFieldName = new String(getselectSet[m].getField());
                        if (selectFieldName.equals("ID")) {
                            ID = new String(result.getResult(i, m));
                            arrID.add(ID);
                        }
                    }// for
                }
            }
        }

        return arrID;

    }

    public static NSingleData getSearchResult(String andKeyword, String orKeyword, String AD, String OPD, String GD, String STATE, int maxSize, int currentPage) throws EarthException
    {
        int ROWSPERPAGE = maxSize;

        int totalResultSize = 0;

        Result result = null;
        Result[] resultlist = null;
        SelectSet[] selectSet = null;
        SelectSet[] getselectSet = null;

        // SelectSet
        if (andKeyword + orKeyword != null && !(andKeyword + orKeyword).equals("")) {
            selectSet = new SelectSet[] {new SelectSet("ID", Protocol.SelectSet.NONE)};

            // WhereSet
            WhereSet[] whereSet = null;

            ArrayList<WhereSet> whereList = new ArrayList<WhereSet>();
            if (!andKeyword.equals("")) {
                whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
                for (int i = 0; i < andKeyword.split("\\^").length; i++) {
                    whereList.add(new WhereSet(andKeyword.split("\\^")[i].split("=")[0], Protocol.WhereSet.OP_HASALL, andKeyword.split("\\^")[i].split("=")[1], 1));

                    if (i < andKeyword.split("\\^").length - 1) whereList.add(new WhereSet(Protocol.WhereSet.OP_AND));
                }
                whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
            }

            if (!orKeyword.equals("")) {
                whereList.add(new WhereSet(Protocol.WhereSet.OP_OR));

                whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));
                for (int i = 0; i < orKeyword.split("\\^").length; i++) {
                    whereList.add(new WhereSet(orKeyword.split("\\^")[i].split("=")[0], Protocol.WhereSet.OP_HASALL, orKeyword.split("\\^")[i].split("=")[1], 1));

                    if (i < andKeyword.split("\\^").length - 1) whereList.add(new WhereSet(Protocol.WhereSet.OP_OR));
                }
                whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
            }

            whereSet = new WhereSet[whereList.size()];
            for (int i = 0; i < whereList.size(); i++) {
                whereSet[i] = whereList.get(i);
            }

            // OrderBySet
            OrderBySet[] orderbys = new OrderBySet[1];
            orderbys[0] = new OrderBySet(true, "weight", Protocol.OrderBySet.OP_PREWEIGHT);

            // FilterSet
            FilterSet[] filterSet = null;

            ArrayList<FilterSet> filterList = new ArrayList<FilterSet>();
            if (!AD.equals("")) filterList.add(new FilterSet(Protocol.FilterSet.OP_RANGE, "AD", new String[] {AD.split("~")[0], AD.split("~")[1]}));

            if (!OPD.equals("")) filterList.add(new FilterSet(Protocol.FilterSet.OP_RANGE, "OPD", new String[] {OPD.split("~")[0], OPD.split("~")[1]}));

            if (!GD.equals("")) filterList.add(new FilterSet(Protocol.FilterSet.OP_RANGE, "GD", new String[] {GD.split("~")[0], GD.split("~")[1]}));

            if (!STATE.equals("")) filterList.add(new FilterSet(Protocol.FilterSet.OP_MATCH, "STATE", STATE));

            filterSet = new FilterSet[filterList.size()];
            for (int i = 0; i < filterList.size(); i++) {
                filterSet[i] = filterList.get(i);
            }

            // QuerySet
            Query query = new Query();
            query.setFrom("search");

            query.setSearchOption(Protocol.SearchOption.CACHE);
            query.setSelect(selectSet);
            query.setWhere(whereSet);
            query.setOrderby(orderbys);
            query.setFilter(filterSet);
            // query.setGroupBy(groups);
            // query.setQueryLogger("template");

            QueryParser queryParser = new QueryParser();
            String tmpProtocolStr = queryParser.queryToString(query);
            System.out.println("<!--protocolStr_query=" + tmpProtocolStr + "<br>-->");

            getselectSet = query.getSelectFields();

            int startnum = (currentPage - 1) * ROWSPERPAGE;
            int endnum = startnum + ROWSPERPAGE - 1;

            query.setResult(startnum, endnum);

            query.setValue("debug", "true");

            QuerySet querySet = new QuerySet(1);
            querySet.addQuery(query);

            CommandSearchRequest.setProps(host, port, 100000, 5, 5);
            CommandSearchRequest command = new CommandSearchRequest(host, port);

            // long start = System.currentTimeMillis();
            int rset = command.request(querySet);
            // long end = System.currentTimeMillis();

            if (rset >= 0) {
                ResultSet results = command.getResultSet();
                resultlist = results.getResultList();
            } else {
                resultlist = new Result[0];
            }
        } else {
            resultlist = new Result[0];
        }

        String selectFieldName = "";
        NSingleData resultData = new NSingleData();
        NMultiData resultList = new NMultiData();

        // ArrayList arrReturnValue = new ArrayList();
        for (int k = 0; resultlist != null && k < resultlist.length; k++) {
            result = resultlist[k];
            totalResultSize = result.getTotalSize();

            if (result != null && totalResultSize > 0) {

                for (int i = 0; i < result.getRealSize(); i++) {
                    String ID = "";

                    // String[] display_value = new String[result.getNumField()];
                    for (int m = 0; m < result.getNumField(); m++) {
                        selectFieldName = new String(getselectSet[m].getField());
                        if (selectFieldName.equals("ID")) {
                            ID = new String(result.getResult(i, m));
                            resultList.setString(resultList.addRow(), "REF_ID", ID);
                        }
                    }// for
                }
            }
        }

        resultData.setInt("TOTAL_SIZE", totalResultSize);
        resultData.set("RESULT_LIST", resultList);

        return resultData;
    }
}
