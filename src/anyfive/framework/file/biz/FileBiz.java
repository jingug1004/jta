package anyfive.framework.file.biz;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.dao.FileDao;
import anyfive.framework.file.util.FileUtil;


public class FileBiz extends NAbstractServletBiz
{
    public FileBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 파일 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveFileList(AjaxRequest xReq) throws NException
    {
        FileDao dao = new FileDao(this.nsr);

        return dao.retrieveFileList(xReq.getParam("FILE_ID"));
    }

    /**
     * 파일 다운로드정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveFileDownload(AjaxRequest xReq) throws NException
    {
        FileDao dao = new FileDao(this.nsr);

        return dao.retrieveFileDownload(xReq);
    }

    /**
     * 파일 목록 저장
     *
     * @param fileList
     * @throws NException
     */
    public void updateFileList(NMultiData fileList) throws NException
    {
        FileDao dao = new FileDao(this.nsr);

        FileUtil.setFileData(this.nsr, fileList);

        dao.deleteFileList(fileList);

        for (int i = 0, ii = fileList.getRowSize(); i < ii; i++) {
            if (fileList.getJobType(i) == NJobTypeEnum.CREATE) dao.createFile(fileList.getSingleData(i));
        }
    }

    /**
     * 파일 목록 삭제
     *
     * @param fileId
     * @throws NException
     */
    public void deleteFileList(String fileId) throws NException
    {

        FileDao dao = new FileDao(this.nsr);

        FileUtil.setFileDataForDelete(this.nsr, dao.retrieveFileList(fileId));

        dao.deleteFileListAll(fileId);
    }
}

