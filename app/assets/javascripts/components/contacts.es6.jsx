class Contacts extends React.Component {
  constructor () {
    super();
    this.state = { contacts: [] }
  }

  render () {
    return (
      <div>
        {this.contactsList()}
      </div>
    );
  }

  componentDidMount () {
    $.get('api/v1/contacts', (data) => { this.setState({ contacts: data }) });
  }
  
  contactsList () {
    return this.state.contacts.map((contact, index) => {
      return <div key={contact.id}><Contact contact={contact} /></div>
    });
  }
}


Contact.propTypes = {
  firstName: React.PropTypes.string,
  lastName: React.PropTypes.string,
  emailAddress: React.PropTypes.string,
  phoneNumber: React.PropTypes.string,
  extension: React.PropTypes.string
};


// <div>
//         <div>First Name: {this.props.firstName}</div>
//         <div>Last Name: {this.props.lastName}</div>
//         <div>Email Address: {this.props.emailAddress}</div>
//         <div>Phone Number: {this.props.phoneNumber}</div>
//         <div>Extension: {this.props.extension}</div>
//       </div>