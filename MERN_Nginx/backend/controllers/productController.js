import Product from "../models/productModel.js";
import asyncHandler from "../middleware/asyncHandler.js";
// @desc Fetch All Products
// @route GET /api/products

const getProducts = asyncHandler(async (req, res) => {
  const products = await Product.find({});
  res.json(products);
});
// @desc Fetch a Product
// @route GET /api/products/:id

const getProductById = asyncHandler(async (req, res) => {
  const product = await Product.findById(req.params.id);
  if (product) {
    res.json(product);
  } else {
    res.status(404).json({ message: "Product Not Found" });
  }
});

export { getProducts, getProductById };
