package JSADUSER.JSADUserinfo;

public class Service1SoapProxy implements JSADUSER.JSADUserinfo.Service1Soap {
  private String _endpoint = null;
  private JSADUSER.JSADUserinfo.Service1Soap service1Soap = null;

  public Service1SoapProxy() {
    _initService1SoapProxy();
  }

  public Service1SoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initService1SoapProxy();
  }

  private void _initService1SoapProxy() {
    try {
      service1Soap = (new JSADUSER.JSADUserinfo.Service1Locator()).getService1Soap();
      if (service1Soap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)service1Soap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)service1Soap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }

    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }

  public String getEndpoint() {
    return _endpoint;
  }

  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (service1Soap != null)
      ((javax.xml.rpc.Stub)service1Soap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);

  }

  public JSADUSER.JSADUserinfo.Service1Soap getService1Soap() {
    if (service1Soap == null)
      _initService1SoapProxy();
    return service1Soap;
  }

  public java.lang.String userInfo(java.lang.String iUserID, java.lang.String iUserPWD) throws java.rmi.RemoteException{
    if (service1Soap == null)
      _initService1SoapProxy();
    return service1Soap.userInfo(iUserID, iUserPWD);
  }

  public java.lang.String ADUserCHK(java.lang.String aUserID, java.lang.String aUserPW) throws java.rmi.RemoteException{
    if (service1Soap == null)
      _initService1SoapProxy();
    return service1Soap.ADUserCHK(aUserID, aUserPW);
  }


}
