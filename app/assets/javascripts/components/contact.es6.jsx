class Contact extends React.Component {
  render () {
    let contact = this.props.contact;
    return (
      <div className="row" key={contact.id}>
        <div className="column">{contact.first_name}</div>
        <div className="column">{contact.last_name}</div>
        <div className="column">{contact.email_address}</div>
        <div className="column">{contact.phone_number}</div>
        <div className="column">{contact.extension}</div>
        <div className="column">{contact.company_name}</div>
      </div>
    )
  }
}