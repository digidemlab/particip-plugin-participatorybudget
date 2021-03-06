/*
 * Copyright (c) 2002-2020, City of Paris
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice
 *     and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright notice
 *     and the following disclaimer in the documentation and/or other materials
 *     provided with the distribution.
 *
 *  3. Neither the name of 'Mairie de Paris' nor 'Lutece' nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * License 1.0
 */
package fr.paris.lutece.plugins.participatorybudget.service.campaign;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;

import fr.paris.lutece.plugins.asynchronousupload.service.AbstractAsynchronousUploadHandler;
import fr.paris.lutece.portal.service.i18n.I18nService;
import fr.paris.lutece.portal.service.util.AppException;
import fr.paris.lutece.portal.service.util.AppPropertiesService;
import fr.paris.lutece.util.filesystem.UploadUtil;

public class CampagneUploadHandler extends AbstractAsynchronousUploadHandler
{
    public static final String BEAN_NAME = "participatorybudget.campagnebpUploadHandler";
    private static final int DEFAULT_MAX_FILE_SIZE = 2097152;
    private static final String HANDLER_NAME = "campagnebpUploadHandler";

    // Error messages
    private static final String ERROR_MESSAGE_MULTIPLE_UPLOAD = "participatorybudget.upload.message.multipleUpload";
    private static final String ERROR_MESSAGE_AVATAR_MAX_SIZE = "participatorybudget.upload.message.avatarMaxSize";
    private static final String ERROR_MESSAGE_AVATAR_MIME_TYPE_AUTORIZED = "participatorybudget.upload.message.avatarMimeTypeAutorized";

    // PROPERTY
    private static final String PROPERTY_AVATAR_MAX_SIZE = "participatorybudget.avatarMaxFileSize";
    private static final String PROPERTY_AVATAR_EXTENSION_AUTORIZED = "participatorybudget.avatarExtensionAutorized";

    // Could be just "images" and "docs"
    /* <sessionId,<fieldName,fileItems>> */
    /* contains uploaded file items */
    private static Map<String, Map<String, List<FileItem>>> _mapAsynchronousUpload = new ConcurrentHashMap<String, Map<String, List<FileItem>>>( );

    @Override
    public void addFileItemToUploadedFilesList( FileItem fileItem, String strFieldName, HttpServletRequest request )
    {
        // This is the name that will be displayed in the form. We keep
        // the original name, but clean it to make it cross-platform.
        String strFileName = UploadUtil.cleanFileName( fileItem.getName( ).trim( ) );

        initMap( request.getSession( ).getId( ), strFieldName );

        // Check if this file has not already been uploaded
        List<FileItem> uploadedFiles = getListUploadedFiles( strFieldName, request.getSession( ) );

        if ( uploadedFiles != null )
        {
            boolean bNew = true;

            if ( !uploadedFiles.isEmpty( ) )
            {
                Iterator<FileItem> iterUploadedFiles = uploadedFiles.iterator( );

                while ( bNew && iterUploadedFiles.hasNext( ) )
                {
                    FileItem uploadedFile = iterUploadedFiles.next( );
                    String strUploadedFileName = UploadUtil.cleanFileName( uploadedFile.getName( ).trim( ) );
                    // If we find a file with the same name and the same
                    // length, we consider that the current file has
                    // already been uploaded
                    bNew = !( StringUtils.equals( strUploadedFileName, strFileName ) && ( uploadedFile.getSize( ) == fileItem.getSize( ) ) );
                }
            }

            if ( bNew )
            {
                uploadedFiles.add( fileItem );
            }
        }
    }

    @Override
    public String canUploadFiles( HttpServletRequest request, String strFieldName, List<FileItem> listFileItemsToUpload, Locale locale )
    {
        int nMaxSize = AppPropertiesService.getPropertyInt( PROPERTY_AVATAR_MAX_SIZE, DEFAULT_MAX_FILE_SIZE );
        String strExtensionAuthorized = AppPropertiesService.getProperty( PROPERTY_AVATAR_EXTENSION_AUTORIZED );

        // Check if this file has not already been uploaded
        List<FileItem> uploadedFiles = getListUploadedFiles( strFieldName, request.getSession( ) );

        if ( uploadedFiles != null && uploadedFiles.size( ) >= 1 )
        {
            return I18nService.getLocalizedString( ERROR_MESSAGE_MULTIPLE_UPLOAD, request.getLocale( ) );
        }

        for ( FileItem fileItem : listFileItemsToUpload )
        {

            if ( !StringUtils.isEmpty( strExtensionAuthorized ) )
            {
                boolean bMimeTypeNotAutorized = true;

                for ( String strExtension : strExtensionAuthorized.split( "," ) )
                {
                    if ( fileItem.getName( ).toLowerCase( ).endsWith( strExtension.toLowerCase( ) ) )
                    {

                        bMimeTypeNotAutorized = false;
                    }

                }

                if ( bMimeTypeNotAutorized )
                {
                    return I18nService.getLocalizedString( ERROR_MESSAGE_AVATAR_MIME_TYPE_AUTORIZED, request.getLocale( ) );
                }
            }

            if ( fileItem.getSize( ) > nMaxSize )
            {
                return I18nService.getLocalizedString( ERROR_MESSAGE_AVATAR_MAX_SIZE, request.getLocale( ) );
            }

        }

        return null;

    }

    @Override
    public String getHandlerName( )
    {
        return HANDLER_NAME;
    }

    @Override
    public List<FileItem> getListUploadedFiles( String strFieldName, HttpSession session )
    {
        if ( StringUtils.isBlank( strFieldName ) )
        {
            throw new AppException( "id field name is not provided for the current file upload" );
        }

        initMap( session.getId( ), strFieldName );

        // find session-related files in the map
        Map<String, List<FileItem>> mapFileItemsSession = _mapAsynchronousUpload.get( session.getId( ) );

        return mapFileItemsSession.get( strFieldName );
    }

    @Override
    public void removeFileItem( String strFieldName, HttpSession session, int nIndex )
    {
        // Remove the file (this will also delete the file physically)
        List<FileItem> uploadedFiles = getListUploadedFiles( strFieldName, session );

        if ( ( uploadedFiles != null ) && !uploadedFiles.isEmpty( ) && ( uploadedFiles.size( ) > nIndex ) )
        {
            // Remove the object from the Hashmap
            FileItem fileItem = uploadedFiles.remove( nIndex );
            fileItem.delete( );
        }
    }

    /**
     * Init the map Copy paste from genericAttribute AbstractGenAttUploadHandler from
     * http://wiki.lutece.paris.fr/lutece/jsp/site/Portal.jsp?page=wiki&page_name=asynchronous_upload&view=page
     * 
     * @param strSessionId
     *            the session id
     * @param strFieldName
     *            the field name
     */
    private void initMap( String strSessionId, String strFieldName )
    {
        // find session-related files in the map
        Map<String, List<FileItem>> mapFileItemsSession = _mapAsynchronousUpload.get( strSessionId );

        // create map if not exists
        if ( mapFileItemsSession == null )
        {
            synchronized( this )
            {
                // Ignore double check locking error : assignation and instanciation of objects are separated.
                mapFileItemsSession = _mapAsynchronousUpload.get( strSessionId );

                if ( mapFileItemsSession == null )
                {
                    mapFileItemsSession = new ConcurrentHashMap<String, List<FileItem>>( );
                    _mapAsynchronousUpload.put( strSessionId, mapFileItemsSession );
                }
            }
        }

        List<FileItem> listFileItems = mapFileItemsSession.get( strFieldName );

        if ( listFileItems == null )
        {
            listFileItems = new ArrayList<FileItem>( );
            mapFileItemsSession.put( strFieldName, listFileItems );
        }
    }

    /**
     * Removes all files associated to the session
     * 
     * @param strSessionId
     *            the session id
     */
    public void removeSessionFiles( String strSessionId )
    {
        _mapAsynchronousUpload.remove( strSessionId );
    }
}
