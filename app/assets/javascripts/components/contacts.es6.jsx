// There's a lot of tools I could use (addons, tables, redux, etc) that I'd normally use
//   but I think I'm trying to keep this as simple & bare bones as possible
//   just like I'm doing on the rails side. I think that allows you probably a bit
//   more insight as to what's going on in my head and how i'd solve things
//   without a lot of tooling (especially in cases where there isn't prebuilt solutions)
//   because it's really easy to actually just say "i'm gonna put stuff together"
//   when it already exists.
class Contacts extends React.Component {
  constructor () {
    super();
    this.state = {
      contacts: [],
      hiddenContacts: []
    }
  }

  /*
   * RENDERING FUNCTIONS
   */

  // Ideally we'd split up the buttons into their own set of components & add them in
  //   as components and pass the contact to them.
  render () {
    return (
      <div className="tableContainer">
        <div className="filterButtons">
          <FilterButton action={this.toggleSortAbc.bind(this)} name={"Sort ABC↓"} />
          <FilterButton action={this.filterDotCom.bind(this)} name={"Filter .com"} />
        </div>
        <div className="table">
          <div className="row"> {this.headerList()} </div>
          {this.contactsList()}
        </div>
      </div>
    );
  }

  // Builds the contact list here.
  contactsList () {
    return this.state.contacts.map((contact, index) => {
      if(this.state.hiddenContacts.indexOf(contact.id) > -1) {
        return;
      }

      return <Contact key={contact.id} contact={contact} removeContact={this.removeContact.bind(this)}/>;
    }.bind(this));
  }

  headerList () {
    return ['First Name', 'Last Name', 'Email', 'Phone Number', 'Extension', 'Company Name'].map((header, index) => {
      return <div className='column header' key={index}>{header}</div>;
    });
  }

  /*
   * DATA!
   */

  // So, we're tapping the API and binding it to the update (ideally we'd only)
  //   pull the contacts when they're updated via various other actions)
  //   and updating it every ten second.
  componentDidMount () {
    this.pullContacts();
    setInterval(this.pullContacts.bind(this), 10000);
  }

  pullContacts () {
    $.get('api/v1/contacts', (data) => {
      this.setState({ contacts: this.contactsSort(data) });
    }.bind(this));
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

  /*
   * Filtering & Sorting!
   * Ideally we'd put these into their own components & pass them Contacts to act
   *   upon (& modify the state). I started doing that with the FilterButton, but,
   *   left most of the work unto the contact to handle it's own changes.
   * Could have composed some of this out too
   */
  // Use a bit of regex, reject all contacts that match the /@\w*.com/ regex,
  //   update the toggle the props (because it's only getting called from one place)
  //   and so on.
  filterDotCom () {
    if(this.props.filtering.dotCom) {
      this.setState({ hiddenContacts: [] })
    } else {
      const re = /@\w*.com/;
      let hiddenContacts = _.reject(this.state.contacts, (contact) => {
        return re.test(contact.email_address)
      });
      this.setState({ hiddenContacts: hiddenContacts.map((contact) => contact.id)})
    }
    this.props.filtering.dotCom = !this.props.filtering.dotCom;
    return this.state.contacts;
  }

  // Toggle the boolean, and then sort it.
  toggleSortAbc (contacts) {
    this.props.sorting.abc = !this.props.sorting.abc;
    this.contactsSort();
  }

  // Ideally, we'd build this to allow for multiple different sorting, and not just have
  //   a bunch of if/elses here & there. There's a little danger w/using setState like
  //   this (namely setState is async & can produce some weird results). Ideally you can
  //   pass in a functional state into setState to manage the state without having
  //   to worry about what's going to come out necessarily. But we're not there yet.
  contactsSort (contacts) {
    contacts = contacts || this.state.contacts;
    if(this.props.sorting.abc) {
      this.setState({ contacts: this.sortByAttribute(contacts, 'email_address')});
    } else {
      this.setState({ contacts: this.sortByAttribute(contacts, 'id')});
    }
    return this.state.contacts;
  }

  sortByAttribute (contactArray, attribute) {
    return contactArray.sort((a, b) => {
      if(a[attribute] > b[attribute]) return 1;
      if(a[attribute] < b[attribute]) return -1;
      return 0
    });
  }
}

Contacts.defaultProps = {
  filtering: {
    dotCom: false,
  },
  sorting: {
    abc: false
  }
}

Contacts.propTypes = {
  filtering: React.PropTypes.object,
  sorting: React.PropTypes.object
}
