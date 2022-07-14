/**
 * Service1Soap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package JSADUSER.JSADUserinfo;

public interface Service1Soap extends java.rmi.Remote {
    public java.lang.String userInfo(java.lang.String iUserID, java.lang.String iUserPWD) throws java.rmi.RemoteException;
    public java.lang.String ADUserCHK(java.lang.String aUserID, java.lang.String aUserPW) throws java.rmi.RemoteException;
}
