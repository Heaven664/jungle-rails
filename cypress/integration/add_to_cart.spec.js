describe('add to cart specs', () => {
  it('visits the home page', () => {
    cy.visit('http://localhost:3000/');
  });

  it('increases number of product in cart by one when clinking on element', () => {
    cy.contains('My Cart (0)')
    cy.get('.btn').contains('Add').first().click({force: true})
    cy.contains('My Cart (1)')
  })

});
