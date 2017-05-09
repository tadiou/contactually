class Contacts extends React.Component {
  constructor () {
    super();
    this.state = { contacts: [] }
  }

  // Render the header, and the contact list, the contact itself becomes a pair of
  //   components, and this provides the structure around the contacts
  render () {
    return (
      <div className="table">
        <div className="row"> {this.headerList()} </div>
        {this.contactsList()}
      </div>
    );
  }

  // So, we're tapping the API and binding it to the update (ideally we'd only)
  //   pull the contacts when they're updated via various other actions)
  //   and updating it every ten second.
  componentDidMount () {
    this.pullContacts();
    // setInterval(this.pullContacts.bind(this), 10000);
  }

  pullContacts () {
    $.get('api/v1/contacts', (data) => { this.setState({ contacts: data }) });
  }
  
  // Builds the contact list here.
  contactsList () {
    return this.state.contacts.map((contact, index) => {
      return <Contact key={contact.id} contact={contact} removeContact={this.removeContact.bind(this)}/>;
    });
  }

  removeContact (contactId) {
    $.ajax({
      url: `api/v1/contacts/${contactId}`,
      type: 'DELETE',
      success: () => {
        this.setState({
          contacts: _.reject(this.state.contacts, {
            id: contactId
          })
        })
      }
    })
  }

  headerList () {
    return ['First Name', 'Last Name', 'Email', 'Phone Number', 'Extension', 'Company Name'].map((header, index) => {
      return <div className='column header' key={index}>{header}</div>;
    });
  }
}

