<?php

namespace App\Http\Controllers;

use App\Models\Property;
use Inertia\Inertia;
use Illuminate\Http\Request;

class PublicPropertyController extends Controller
{
    /**
     * Afficher tous les biens DISPONIBLES (non loués)
     */
    public function index(Request $request)
    {
        $properties = Property::query()
            ->where('status', 'disponible')
            ->latest()
            ->paginate(12);
        
        return Inertia::render('Public/Properties/Index', [
            'properties' => $properties,
            'filters' => $request->only(['type', 'search', 'min_price', 'max_price'])
        ]);
    }
    
    /**
     * Détails d'un bien (accessible à tous)
     */
    public function show(Property $property)
    {
        if ($property->status !== 'disponible') {
            abort(404, 'Ce bien n\'est plus disponible');
        }
        
        return Inertia::render('Public/Properties/Show', [
            'property' => $property
        ]);
    }
    
    /**
     * Formulaire de contact
     */
    public function contact(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email',
            'phone' => 'nullable|string',
            'message' => 'required|string',
            'property_id' => 'required|exists:properties,id'
        ]);
        
        return back()->with('success', 'Votre message a été envoyé !');
    }
}
