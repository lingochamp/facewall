Collection = require './collection'

# By default, email addresses with no Gravatars will be hidden from the Facewall.
# However, adding ?shame to the request URL will show these as empty squares in the Facewall mesh.
defaultGravatarImage = if location.search isnt '?shame' then '404' else 'blank'
images = [
    'http://cdn-l.llsapp.com/connett/9c37cfa1-12ba-4814-aae4-419a5f3e1171',
    'http://cdn-l.llsapp.com/connett/94cc71e1-e6af-4344-a8bc-f3aef015d76e',
    'http://cdn-l.llsapp.com/connett/ef1d9340-0ddc-451f-b5cc-81e663af910f',
    'http://cdn-l.llsapp.com/connett/8a1b42af-8fc5-4c43-aacb-20dd8cf62ac3'
  ]
USER_JSON = """{"users":[{"firstName":"Adam","lastName":"Schwartz","email":"aschwartz@hubspot.com","role": "iOS工程师"},{"firstName":"Brad","lastName":"Osgood","email":"bosgood@hubspot.com","role": "iOS工程师"},{"firstName":"Chris","lastName":"Kelly","email":"ckelly@hubspot.com","role": "iOS工程师"},{"firstName":"David","lastName":"Cancel","email":"dcancel@hubspot.com","role": "iOS工程师"},{"firstName":"Jeremy","lastName":"Crane","email":"jcrane@hubspot.com","role": "iOS工程师"},{"firstName":"Mike","lastName":"Axiak","email":"maxiak@hubspot.com","role": "iOS工程师"},{"firstName":"Michael","lastName":"Mintz","email":"mmintz@hubspot.com","role": "iOS工程师"},{"firstName":"Rachel","lastName":"Decker","email":"rdecker@hubspot.com","role": "iOS工程师"},{"firstName":"Sam","lastName":"Siskend","email":"ssiskind@hubspot.com","role": "iOS工程师"},{"firstName":"Trevor","lastName":"Burnam","email":"tburnham@hubspot.com","role": "iOS工程师"},{"firstName":"Tim","lastName":"Finley","email":"tfinley@hubspot.com","role": "iOS工程师"},{"firstName":"Tom","lastName":"Monaghan","email":"tmonaghan@hubspot.com","role": "iOS工程师"},{"firstName":"Zack","lastName":"Bloom","email":"zbloom@hubspot.com"},{"firstName":"Adam","lastName":"Schwartz","email":"aschwart@hubspot.com","role": "iOS工程师"},{"firstName":"Brad","lastName":"Osgood","email":"bosood@hubspot.com","role": "iOS工程师"},{"firstName":"Chris","lastName":"Kelly","email":"cklly@hubspot.com","role": "iOS工程师"},{"firstName":"David","lastName":"Cancel","email":"dancel@hubspot.com","role": "iOS工程师"},{"firstName":"Jeremy","lastName":"Crane","email":"jrane@hubspot.com","role": "iOS工程师"},{"firstName":"Mike","lastName":"Axiak","email":"maiak@hubspot.com","role": "iOS工程师"},{"firstName":"Michael","lastName":"Mintz","email":"mintz@hubspot.com","role": "iOS工程师"},{"firstName":"Rachel","lastName":"Decker","email":"decker@hubspot.com","role": "iOS工程师"},{"firstName":"Sam","lastName":"Siskend","email":"siskind@hubspot.com","role": "iOS工程师"},{"firstName":"Trevor","lastName":"Burnam","email":"tbrnham@hubspot.com","role": "iOS工程师"},{"firstName":"Tim","lastName":"Finley","email":"tfiney@hubspot.com","role": "iOS工程师"},{"firstName":"Tom","lastName":"Monaghan","email":"tonaghan@hubspot.com","role": "iOS工程师"},{"firstName":"Zack","lastName":"Bloom","email":"zboom@hubspot.com"}]}"""

class Employees extends Collection

    # Replace this with your own database of employees.
    # You may use a URL which returns JSON in the following format:
    # {
    #    "users":[
    #       {
    #          "id": 1,
    #          "createdAt": 1282254176000,
    #          "email": "aschwartz@hubspot.com",
    #          "firstName": "Adam",
    #          "lastName": "Schwartz",
    #          "role": "Principal Software Engineer"
    #       },
    #       // ...
    #    ]
    # }
    # url: -> "/my-organization-user-database"

    # Or you may hard code a JSON string in place of the example USER_JSON (see above)
    fetch: (options) ->
        @add @parse JSON.parse USER_JSON
        setTimeout (-> options.success()), 100

    parse: (data) ->
        _.map data.users, (employee,index) =>
            employee.gravatar = images[index % 4]

            # Default to showing full name when role is not available
            employee.role = employee.firstName + ' ' + employee.lastName unless employee.role

            employee

module.exports = Employees