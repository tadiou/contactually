class UploadContacts extends React.Component {
  render () {
    return (
      <div className="uploadButtons">
        <input id="uploadContactsFile" type="file" />
        <button onClick={this.uploadFile}>Submit</button>
      </div>
    )
  }

  uploadFile () {
    let formData = new FormData();
    let file = $('#uploadContactsFile')[0].files[0];
    if (file === undefined){
      return; 
    }
    formData.append('csv_upload', file);
    $.ajax({
      url: 'api/v1/contacts/uploads',
      type: 'POST',
      contentType: false,
      processData: false,
      data: formData
    })
  }
}
